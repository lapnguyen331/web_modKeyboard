package org.modKeyboard.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.modKeyboard.util.UUIDGenerator;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDate;
import java.util.UUID;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "popular_products")
public class PopularProduct {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", type = UUIDGenerator.class)
    @Column(updatable = false, columnDefinition = "char(36)")
    @JdbcTypeCode(SqlTypes.CHAR)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "total_sold", nullable = false)
    private Integer totalSold = 0;

    @Column(name = "time_period")
    @Enumerated(EnumType.STRING)
    private TimePeriod timePeriod;

    @Column(name = "period_start", nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate periodStart;

    @Column(name = "period_end", nullable = false)
    @Temporal(TemporalType.DATE)
    private LocalDate periodEnd;

    // Enum
    public enum TimePeriod {
        DAY, WEEK, MONTH, ALL_TIME
    }

    // Getters and Setters
}